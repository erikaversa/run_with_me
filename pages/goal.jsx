import { useState } from "react";
import { supabase } from "@/lib/supabaseClient";

export default function Goal() {
  const [distance, setDistance] = useState("half-marathon");
  const [targetPace, setTargetPace] = useState("");
  const [notes, setNotes] = useState("");
  const [saved, setSaved] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    const user = await supabase.auth.getUser();
    const userId = user.data?.user?.id;

    if (!userId) {
      alert("Please log in to save your goal.");
      return;
    }

    const { error } = await supabase.from("goals").insert({
      user_id: userId,
      distance,
      target_pace: targetPace,
      notes,
    });

    if (error) {
      console.error("Error saving goal:", error);
      alert("Failed to save goal.");
    } else {
      setSaved(true);
      alert("Goal saved!");
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-yellow-100 to-orange-200 p-8 flex flex-col items-center">
      <h1 className="text-4xl font-extrabold text-gray-800 mb-8">Goal</h1>

      <form
        onSubmit={handleSubmit}
        className="bg-white p-6 rounded-xl shadow-md max-w-md w-full space-y-6"
      >
        <label className="block">
          <span className="text-lg font-semibold text-gray-700 mb-2 block">Select your training goal</span>
          <select
            className="w-full border border-gray-300 rounded-md p-2"
            value={distance}
            onChange={(e) => setDistance(e.target.value)}
          >
            <option value="5k">5K</option>
            <option value="10k">10K</option>
            <option value="half-marathon">Half Marathon</option>
            <option value="marathon">Marathon</option>
            <option value="ultra">Ultra Marathon</option>
          </select>
        </label>

        <label className="block">
          <span className="text-lg font-semibold text-gray-700 mb-2 block">Target Pace (min/km)</span>
          <input
            type="text"
            placeholder="e.g. 6:00"
            className="w-full border border-gray-300 rounded-md p-2"
            value={targetPace}
            onChange={(e) => setTargetPace(e.target.value)}
          />
        </label>

        <label className="block">
          <span className="text-lg font-semibold text-gray-700 mb-2 block">Additional Notes</span>
          <textarea
            rows={4}
            placeholder="Add any notes or motivation"
            className="w-full border border-gray-300 rounded-md p-2"
            value={notes}
            onChange={(e) => setNotes(e.target.value)}
          />
        </label>

        <button
          type="submit"
          className="w-full py-3 bg-yellow-500 hover:bg-yellow-600 text-white font-semibold rounded-md transition"
          disabled={saved}
        >
          {saved ? "Goal Saved" : "Save Goal"}
        </button>
      </form>
    </div>
  );
}