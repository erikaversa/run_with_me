import HeartRateMonitor from "@/components/HeartRateMonitor";

export default function Parameter() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-100 to-pink-200 p-8">
      <h1 className="text-4xl font-extrabold text-gray-800 mb-6 text-center">
        Parameter
      </h1>

      <div className="max-w-4xl mx-auto space-y-12">
        {/* Heart Rate Monitor */}
        <section>
          <h2 className="text-2xl font-semibold mb-4">Heart Rate Monitor</h2>
          <HeartRateMonitor />
        </section>

        {/* Vo₂ Max Placeholder */}
        <section>
          <h2 className="text-2xl font-semibold mb-4">Vo₂ Max Estimate</h2>
          <div className="p-6 bg-white rounded-xl shadow-md text-center text-gray-600">
            {/* Here you can add graphs or data later */}
            <p className="italic">Vo₂ max estimation coming soon...</p>
          </div>
        </section>

        {/* History Placeholder */}
        <section>
          <h2 className="text-2xl font-semibold mb-4">History</h2>
          <div className="p-6 bg-white rounded-xl shadow-md text-center text-gray-600">
            <p className="italic">Training history and trends will appear here.</p>
          </div>
        </section>
      </div>
    </div>
  );
}