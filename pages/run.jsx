import { useState, useEffect, useRef } from "react";
import { useRouter } from 'next/router';
import { TEST_USER, TEST_SESSIONS, TEST_GOAL, TEST_HEART_RATE_TREND } from "@/lib/testSessions";

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

  // Use hardcoded user for testing
  useEffect(() => {
    setUser(TEST_USER);
  }, []);

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

  const handleFinishRun = () => {
    setSaveStatus('Session saved!');
    setIsRunning(false);
    setSecondsElapsed(0);
    setDistanceKm(0);
  };

  const handleSaveSession = () => {
    setSaveStatus('Session saved!');
  };

  if (!user) return <p>Loading...</p>;

  // Example: Display test session history below the run controls
  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-gradient-to-br from-green-100 to-blue-100 px-6 py-12 text-center space-y-8">
      <h1 className="text-4xl font-extrabold text-gray-800">Run</h1>
      <div className="bg-white rounded-xl p-8 shadow-lg w-full max-w-md">
        <div className="text-6xl font-mono font-bold text-gray-900">
          <span className="text-4xl">{formatTime(secondsElapsed)}</span>
        </div>
        <div className="mt-6 flex justify-around text-gray-700 text-xl font-semibold">
          <div>
            <div className="text-sm font-normal text-gray-500">Distance</div>
            <div className="text-base font-bold">{distanceKm.toFixed(2)} km</div>
          </div>
          <div>
            <div className="text-sm font-normal text-gray-500">Pace</div>
            <div className="text-base font-bold">{paceFormatted}</div>
          </div>
        </div>
        <div className="mt-8 flex justify-center space-x-6 flex-wrap">
          {!isRunning && (
            <button
              onClick={() => setIsRunning(true)}
              className="px-8 py-4 text-lg bg-green-500 hover:bg-green-600 text-black rounded-xl font-semibold transition"
            >
              Start
            </button>
          )}
          {isRunning && (
            <button
              onClick={() => setIsRunning(false)}
              className="px-8 py-4 text-lg bg-yellow-500 hover:bg-yellow-600 text-black rounded-xl font-semibold transition"
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
            className="px-8 py-4 text-lg bg-red-500 hover:bg-red-600 text-black rounded-xl font-semibold transition"
          >
            Reset
          </button>
          <button
            onClick={handleFinishRun}
            className="px-8 py-4 text-lg bg-blue-600 hover:bg-blue-700 text-black rounded-xl font-semibold transition"
            disabled={secondsElapsed === 0 || distanceKm === 0}
          >
            Finish Run
          </button>
          <button
            onClick={handleSaveSession}
            disabled={secondsElapsed === 0}
            className="px-8 py-4 text-lg bg-blue-600 hover:bg-blue-700 text-black rounded-xl font-semibold transition disabled:opacity-50"
          >
            Save Session
          </button>
        </div>
        {saveStatus && <div className="mt-4 text-center text-green-600">{saveStatus}</div>}
      </div>
      <div className="mt-12 w-full max-w-xl mx-auto">
        <h2 className="text-2xl font-bold mb-4 text-left">Test Session History</h2>
        <ul className="space-y-2">
          {TEST_SESSIONS.map((session) => (
            <li key={session.id} className="bg-black rounded-lg shadow p-4 flex justify-between items-center">
              <span className="font-semibold">{session.date}</span>
              <span className="text-base font-bold">{session.distance_km} km</span>
              <span className="text-base font-bold">{Math.floor(session.duration_sec / 60)} min</span>
              <span className="text-base font-bold">Avg HR: {session.avg_hr}</span>
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}