import { useEffect, useState } from 'react';
import { supabase } from '@/lib/supabaseClient';
import { Line } from 'react-chartjs-2';
import {
  Chart as ChartJS,
  LineElement,
  CategoryScale,
  LinearScale,
  PointElement,
  Tooltip,
  Legend,
} from 'chart.js';

ChartJS.register(LineElement, CategoryScale, LinearScale, PointElement, Tooltip, Legend);

export default function ProgressDashboard() {
  const [sessions, setSessions] = useState([]);
  const [goal, setGoal] = useState(null);

  // Function to fetch goal and sessions
  async function fetchData() {
    const user = await supabase.auth.getUser();
    const userId = user.data?.user?.id;
    if (!userId) return;

    // Fetch latest goal
    const { data: goalsData, error: goalsError } = await supabase
      .from('goals')
      .select('*')
      .eq('user_id', userId)
      .order('created_at', { ascending: false })
      .limit(1)
      .single();

    if (goalsError) console.error('Error fetching goal:', goalsError);
    else setGoal(goalsData);

    // Fetch sessions
    const { data: sessionsData, error: sessionsError } = await supabase
      .from('sessions')
      .select('*')
      .eq('user_id', userId)
      .order('date', { ascending: false });

    if (sessionsError) console.error('Error fetching sessions:', sessionsError);
    else setSessions(sessionsData);
  }

  useEffect(() => {
    fetchData();

    // Subscribe to sessions changes
    const subscription = supabase
      .channel('public:sessions')
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'sessions' },
        (payload) => {
          console.log('Session change received:', payload);
          // Refetch data on change
          fetchData();
        }
      )
      .subscribe();

    return () => {
      supabase.removeChannel(subscription);
    };
  }, []);

  const mockLabels = sessions.map((s) => s.date);
  const mockHR = sessions.map((s) => s.avg_hr);

  const data = {
    labels: mockLabels,
    datasets: [
      {
        label: 'Avg HR (bpm)',
        data: mockHR,
        fill: false,
        backgroundColor: '#6366F1',
        borderColor: '#6366F1',
        tension: 0.3,
      },
    ],
  };

  const options = {
    responsive: true,
    plugins: {
      legend: {
        display: true,
        position: 'top',
      },
    },
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-violet-100 to-indigo-100 p-8">
      <h1 className="text-4xl font-extrabold text-gray-800 mb-8 text-center">Progress Dashboard</h1>

      <div className="max-w-4xl mx-auto grid grid-cols-1 md:grid-cols-2 gap-8">
        {/* Goals Summary */}
        <div className="bg-white p-6 rounded-xl shadow">
          <h2 className="text-2xl font-semibold mb-4">Goal Overview</h2>
          {goal ? (
            <>
              <p className="text-gray-700">Target: {goal.distance}</p>
              <p className="text-gray-700">Target Pace: {goal.target_pace} min/km</p>
              <p className="text-gray-700">Progress: {sessions.length} sessions completed</p>
            </>
          ) : (
            <p className="text-gray-700 italic">No goal set yet.</p>
          )}
        </div>

        {/* Heart Rate Chart */}
        <div className="bg-white p-6 rounded-xl shadow">
          <h2 className="text-2xl font-semibold mb-4">Heart Rate Trend</h2>
          <Line data={data} options={options} />
        </div>

        {/* Session Summary */}
        <div className="md:col-span-2 bg-white p-6 rounded-xl shadow">
          <h2 className="text-2xl font-semibold mb-4">Recent Sessions</h2>
          <ul className="text-gray-700 space-y-2">
            {sessions.map((session) => (
              <li key={session.id}>
                🗓️ {session.date}: {session.distance_km} km – {Math.floor(session.duration_sec / 60)} min – Avg HR: {session.avg_hr}
              </li>
            ))}
          </ul>
        </div>
      </div>
    </div>
  );
}
