import { useState, useEffect, useRef } from "react";
import { supabase } from "@/lib/supabaseClient";
import { useRouter } from 'next/router';

export default function Run() {
  const [isRunning, setIsRunning] = useState(false);
  const [secondsElapsed, setSecondsElapsed] = useState(0);
  const [distanceKm, setDistanceKm] = useState(0);
  const [user, setUser] = useState(null);
  const [saveStatus, setSaveStatus] = useState("");
  const timerRef = useRef(null);
  const router = useRouter();

  // Simulate distance increase: assume 10 km/h pace when running
  const paceKmPerSec = 10 / 3600;

  useEffect(() => {
    async function checkSession() {
      const { data } = await supabase.auth.getSession();
      if (!data?.session) {
        router.push('/login');
      } else {
        setUser(data.session.user);
      }
    }
    checkSession();
  }, [router]);

  useEffect(() => {
    if (isRunning) {
      timerRef.current = setInterval(() => {
        setSecondsElapsed((prev) => prev + 1);
        setDistanceKm((prev) => prev + paceKmPerSec);
      }, 1000);
    } else {
      clearInterval(timerRef.current);
    }
    return () => clearInterval(timerRef.current);
  }, [isRunning]);

  const formatTime = (secs) => {
    const h = Math.floor(secs / 3600);
    const m = Math.floor((secs % 3600) / 60);
    const s = secs % 60;
    return [
      h > 0 ? h.toString().padStart(2, "0") : null,
      m.toString().padStart(2, "0"),
      s.toString().padStart(2, "0"),
    ]
      .filter(Boolean)
      .join(":");
  };

  const pacePerKm = secondsElapsed > 0 ? secondsElapsed / distanceKm : 0;
  const paceFormatted = pacePerKm
    ? `${Math.floor(pacePerKm / 60)}:${Math.floor(pacePerKm % 60)
        .toString()
        .padStart(2, "0")} min/km`
    : "--:--";

  const handleFinishRun = async () => {
    if (!user) return;
    const { error } = await supabase.from('sessions').insert([
      {
        user_id: user.id,
        distance_km: distanceKm,
        duration_sec: secondsElapsed,
        date: new Date().toISOString(),
      },
    ]);
    if (error) {
      setSaveStatus('Error saving session.');
    } else {
      setSaveStatus('Session saved!');
      setIsRunning(false);
      setSecondsElapsed(0);
      setDistanceKm(0);
    }
  };

  const handleSaveSession = async () => {
    const avg_hr = 150; // placeholder, can be replaced with real input
    const user = await supabase.auth.getUser();
    const userId = user.data?.user?.id;

    if (!userId) {
      alert("User not logged in. Please log in first.");
      return;
    }

    const { error } = await supabase.from("sessions").insert({
      user_id: userId,
      distance_km: parseFloat(distanceKm.toFixed(2)),
      duration_sec: secondsElapsed,
      avg_hr: avg_hr,
      date: new Date().toISOString().split("T")[0],
    });

    if (error) {
      console.error("Error saving session:", error);
      alert("Failed to save session.");
    } else {
      setSaveStatus('Session saved!');
      alert("Session saved!");
    }
  };

  if (!user) return <p>Loading...</p>;

  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-gradient-to-br from-green-100 to-blue-100 px-6 py-12 text-center space-y-8">
      <h1 className="text-4xl font-extrabold text-gray-800">Run</h1>
      <div className="bg-white rounded-xl p-8 shadow-lg w-full max-w-md">
        <div className="text-6xl font-mono font-bold text-gray-900">
          {formatTime(secondsElapsed)}
        </div>
        <div className="mt-6 flex justify-around text-gray-700 text-xl font-semibold">
          <div>
            <div className="text-sm font-normal text-gray-500">Distance</div>
            <div>{distanceKm.toFixed(2)} km</div>
          </div>
          <div>
            <div className="text-sm font-normal text-gray-500">Pace</div>
            <div>{paceFormatted}</div>
          </div>
        </div>
        <div className="mt-8 flex justify-center space-x-4 flex-wrap">
          {!isRunning && (
            <button
              onClick={() => setIsRunning(true)}
              className="px-6 py-3 bg-green-500 hover:bg-green-600 text-white rounded-lg font-semibold transition"
            >
              Start
            </button>
          )}
          {isRunning && (
            <button
              onClick={() => setIsRunning(false)}
              className="px-6 py-3 bg-yellow-500 hover:bg-yellow-600 text-white rounded-lg font-semibold transition"
            >
              Pause
            </button>
          )}
          <button
            onClick={() => {
              setIsRunning(false);
              setSecondsElapsed(0);
              setDistanceKm(0);
              setSaveStatus("");
            }}
            className="px-6 py-3 bg-red-500 hover:bg-red-600 text-white rounded-lg font-semibold transition"
          >
            Reset
          </button>
          <button
            onClick={handleFinishRun}
            className="px-6 py-3 bg-blue-600 hover:bg-blue-700 text-white rounded-lg font-semibold transition"
            disabled={secondsElapsed === 0 || distanceKm === 0}
          >
            Finish Run
          </button>
          <button
            onClick={handleSaveSession}
            disabled={secondsElapsed === 0}
            className="px-6 py-3 bg-blue-600 hover:bg-blue-700 text-white rounded-lg font-semibold transition disabled:opacity-50"
          >
            Save Session
          </button>
        </div>
        {saveStatus && <div className="mt-4 text-center text-green-600">{saveStatus}</div>}
      </div>
    </div>
  );
}