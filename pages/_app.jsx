import BottomNavBar from "@/components/BottomNavBar";

function MyApp({ Component, pageProps }) {
  return (
    <div className="flex flex-col md:flex-row min-h-screen">
      <BottomNavBar />
      <main className="flex-1 p-4 md:ml-20 md:pt-4">
        <Component {...pageProps} />
      </main>
    </div>
  );
}

export default MyApp;
