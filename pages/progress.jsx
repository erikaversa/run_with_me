import { useEffect, useState } from "react";
import { supabase } from "@/lib/supabaseClient";
import { useRouter } from "next/router";
import ProgressDashboard from "@/components/ProgressDashboard";

export default function ProgressPage() {
  const router = useRouter();
  const [user, setUser] = useState(null);

  useEffect(() => {
    async function checkSession() {
      const { data, error } = await supabase.auth.getSession();
      if (!data?.session) {
        router.push("/login");
      } else {
        setUser(data.session.user);
      }
    }
    checkSession();
  }, [router]);

  if (!user) return <p>Loading...</p>;

  return (
    <div className="p-6">
      Welcome, {user.email}
      <button
        onClick={() => supabase.auth.signOut()}
        className="mt-4 px-4 py-2 bg-red-500 text-white rounded"
      >
        Sign out
      </button>
      <ProgressDashboard />
    </div>
  );
}
