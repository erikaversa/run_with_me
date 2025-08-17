import React, { useState } from 'react';
import Link from 'next/link';

export default function HomePage() {
  const [isRunning, setIsRunning] = useState(false);
  const [secondsElapsed, setSecondsElapsed] = useState(0);
  const [distanceKm, setDistanceKm] = useState(0);
  const [saveStatus, setSaveStatus] = useState("");

  const handleFinishRun = () => {
    // Logic for finishing the run
  };

  const handleSaveSession = () => {
    // Logic for saving the session
  };

  // Simulation test data
  const simulationSessions = [
    { date: "2025-06-02", distance_km: 10.0, duration_min: 38, pace_min_per_km: "7:36" },
    { date: "2025-06-03", distance_km: 3.2, duration_min: 45, pace_min_per_km: "7:15" },
    { date: "2025-06-04", distance_km: 20.5, duration_min: 32, pace_min_per_km: "7:07" },
    { date: "2025-06-05", distance_km: 12.8, duration_min: 42, pace_min_per_km: "7:14" },
    { date: "2025-06-06", distance_km: 7.0, duration_min: 50, pace_min_per_km: "7:08" },
  ];

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-100 to-purple-200 flex items-center justify-center px-4 md:px-12">
      {/* Container */}
      <div className="max-w-6xl w-full grid grid-cols-1 md:grid-cols-12 gap-8 items-center">
        {/* Left Data Blocks */}
        <div className="md:col-span-4 space-y-8 w-full">
          {/* Block 1 */}
          <div className="bg-white rounded-2xl shadow-lg p-8 text-center">
            <p className="text-gray-500 uppercase tracking-wide font-semibold mb-2">Distance (KM)</p>
            <p className="text-5xl font-extrabold text-indigo-700">12.4</p>
          </div>
          {/* Block 2 */}
          <div className="bg-white rounded-2xl shadow-lg p-8 text-center">
            <p className="text-gray-500 uppercase tracking-wide font-semibold mb-2">Time</p>
            <p className="text-5xl font-extrabold text-indigo-700">01:05:23</p>
          </div>
          {/* Block 3 */}
          <div className="bg-white rounded-2xl shadow-lg p-8 text-center">
            <p className="text-gray-500 uppercase tracking-wide font-semibold mb-2">Pace</p>
            <p className="text-5xl font-extrabold text-indigo-700">5:18 min/km</p>
          </div>
        </div>

        {/* Center Avatar */}
        <div className="md:col-span-4 flex flex-col items-center justify-center w-full">
          {/* Avatar circle */}
          <div className="w-48 h-48 rounded-full bg-gradient-to-br from-purple-500 to-indigo-700 flex items-center justify-center shadow-2xl relative">
            <span className="text-white text-6xl font-extrabold select-none">A & E</span>
            {/* Optional glowing pulse */}
            <span className="absolute w-60 h-60 rounded-full bg-purple-400 opacity-30 animate-ping"></span>
          </div>
          <p className="mt-6 text-xl font-semibold text-gray-800">Erika & Aión</p>
          <p className="mt-2 text-center text-gray-600 max-w-xs">Your AI-powered running companion. Track your progress, set goals, and run together!</p>
        </div>

        {/* Right Side Controls */}
        <div className="md:col-span-4 space-y-10 w-full">
          <Link href="/run" passHref legacyBehavior>
            <a className="block w-full py-5 bg-indigo-600 hover:bg-indigo-700 text-white rounded-3xl font-bold text-2xl text-center transition">
              RUN
            </a>
          </Link>
          <div className="bg-white rounded-2xl shadow-lg p-8 text-center">
            <p className="text-gray-500 uppercase tracking-wide font-semibold mb-2">Goal</p>
            <p className="text-4xl font-extrabold text-indigo-700">Half Marathon</p>
          </div>
          <div className="bg-white rounded-2xl shadow-lg p-8 text-center">
            <p className="text-gray-500 uppercase tracking-wide font-semibold mb-2">Coaching</p>
            <p className="text-xl font-semibold text-red-600">Paused</p>
          </div>

          {/* Control Buttons */}
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
        </div>
      </div>

      {/* Simulation Test Section */}
      <div className="mt-12 w-full max-w-xl mx-auto">
        <h2 className="text-2xl font-bold mb-4 text-left">Simulation Test Sessions</h2>
        <ul className="space-y-2">
          {simulationSessions.map((session, idx) => (
            <li key={idx} className="bg-white rounded-lg shadow p-4 flex justify-between items-center">
              <span className="font-semibold">{session.date}</span>
              <span className="text-base font-bold">{session.distance_km} km</span>
              <span className="text-base font-bold">{session.duration_min} min</span>
              <span className="text-base font-bold">Pace: {session.pace_min_per_km} min/km</span>
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}

// Only keep this index.jsx file as the home page. Remove or rename any index.js, index.tsx, or index.ts files in the pages directory to avoid conflicts.