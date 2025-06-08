import { useState } from "react";

export default function Settings() {
  // Body parameters state
  const [age, setAge] = useState(30);
  const [weight, setWeight] = useState(65);
  const [height, setHeight] = useState(170);

  // Sensor preferences state
  const [hrMonitorEnabled, setHrMonitorEnabled] = useState(true);

  // Thresholds (example: HR zones)
  const [maxHr, setMaxHr] = useState(190);
  const [alertHr, setAlertHr] = useState(180);

  const handleSubmit = (e) => {
    e.preventDefault();
    alert(
      `Settings saved:\nAge: ${age}\nWeight: ${weight}kg\nHeight: ${height}cm\nHR Monitor: ${
        hrMonitorEnabled ? "On" : "Off"
      }\nMax HR: ${maxHr}\nAlert HR: ${alertHr}`
    );
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-gray-100 to-gray-200 p-8">
      <h1 className="text-4xl font-extrabold text-gray-800 mb-8 text-center">
        Settings
      </h1>

      <form
        onSubmit={handleSubmit}
        className="max-w-lg mx-auto bg-white p-6 rounded-xl shadow-md space-y-6"
      >
        {/* Body Parameters */}
        <fieldset>
          <legend className="text-xl font-semibold mb-4">Body Parameters</legend>

          <label className="block mb-2">
            Age:
            <input
              type="number"
              min="10"
              max="120"
              value={age}
              onChange={(e) => setAge(Number(e.target.value))}
              className="w-full mt-1 px-3 py-2 border rounded-md"
            />
          </label>

          <label className="block mb-2">
            Weight (kg):
            <input
              type="number"
              min="20"
              max="200"
              value={weight}
              onChange={(e) => setWeight(Number(e.target.value))}
              className="w-full mt-1 px-3 py-2 border rounded-md"
            />
          </label>

          <label className="block mb-2">
            Height (cm):
            <input
              type="number"
              min="100"
              max="250"
              value={height}
              onChange={(e) => setHeight(Number(e.target.value))}
              className="w-full mt-1 px-3 py-2 border rounded-md"
            />
          </label>
        </fieldset>

        {/* Sensor Preferences */}
        <fieldset>
          <legend className="text-xl font-semibold mb-4">Sensor Preferences</legend>

          <label className="flex items-center space-x-3">
            <input
              type="checkbox"
              checked={hrMonitorEnabled}
              onChange={() => setHrMonitorEnabled(!hrMonitorEnabled)}
              className="h-5 w-5"
            />
            <span>Enable Heart Rate Monitor</span>
          </label>
        </fieldset>

        {/* Thresholds */}
        <fieldset>
          <legend className="text-xl font-semibold mb-4">Heart Rate Thresholds</legend>

          <label className="block mb-2">
            Maximum Heart Rate:
            <input
              type="number"
              min="100"
              max="220"
              value={maxHr}
              onChange={(e) => setMaxHr(Number(e.target.value))}
              className="w-full mt-1 px-3 py-2 border rounded-md"
            />
          </label>

          <label className="block mb-2">
            Alert Heart Rate:
            <input
              type="number"
              min="100"
              max="220"
              value={alertHr}
              onChange={(e) => setAlertHr(Number(e.target.value))}
              className="w-full mt-1 px-3 py-2 border rounded-md"
            />
          </label>
        </fieldset>

        <button
          type="submit"
          className="w-full py-3 bg-blue-600 text-white font-semibold rounded-md hover:bg-blue-700 transition"
        >
          Save Settings
        </button>
      </form>
    </div>
  );
}