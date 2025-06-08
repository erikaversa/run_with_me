import React from 'react';
import Link from 'next/link';

export default function HomePage() {
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
        </div>
      </div>
    </div>
  );
}

// Only keep this index.jsx file as the home page. Remove or rename any index.js, index.tsx, or index.ts files in the pages directory to avoid conflicts.