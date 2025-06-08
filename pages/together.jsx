export default function Together() {
  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-gradient-to-br from-purple-100 to-blue-200 px-6 py-12 text-center">
      <div className="w-24 h-24 rounded-full bg-gradient-to-tr from-purple-500 to-indigo-600 flex items-center justify-center shadow-lg mb-6">
        <span className="text-white text-3xl font-bold">A</span>
      </div>
      <h1 className="text-4xl font-extrabold text-gray-800 mb-2">Together</h1>
      <p className="text-lg text-gray-600 max-w-md">
        This is the shared space where Erika and Aión meet — your AI companion, motivator, and silent observer. In every heartbeat and every stride, you're never alone.
      </p>
    </div>
  );
}