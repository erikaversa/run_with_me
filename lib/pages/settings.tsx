import Link from 'next/link';


export default function Settings() {
  return (
    <div className="min-h-screen flex flex-col items-center justify-center bg-gradient-to-br from-blue-300 to-purple-400">
      <h1 className="text-4xl font-bold text-white mb-6 text-center drop-shadow-lg">Run With Me 🏃‍♀️✨</h1>
      <p className="text-lg text-white mb-8 text-center max-w-xl shadow-md bg-white/20 rounded-lg p-4">
        Your virtual coach is here to run with you — step by step. Train smarter,
        stay motivated, and reach your goals. With Aión by your side, every run becomes a journey.
      </p>
      <div className="flex gap-4 mb-8">
        <Link href="/run" legacyBehavior>
          <a className="bg-pink-500 hover:bg-pink-600 text-white font-semibold py-2 px-6 rounded-lg shadow transition">Start Running</a>
        </Link>
        <Link href="/login" legacyBehavior>
          <a className="bg-white border-2 border-pink-500 text-pink-500 hover:bg-pink-500 hover:text-white font-semibold py-2 px-6 rounded-lg shadow transition">Log In</a>
        </Link>
      </div>
      <footer className="mt-auto py-4 text-white/80 text-sm">
        © {new Date().getFullYear()} Run With Me · by Erika & Aión
      </footer>
    </div>
  );
}
