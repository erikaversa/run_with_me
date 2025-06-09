import Head from "next/head";
import BottomNavBar from "@/components/BottomNavBar";

function MyApp({ Component, pageProps }) {
  return (
    <>
      <Head>
        {/* Noto Sans and Noto Color Emoji from Google Fonts */}
        <link
          href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;700&display=swap"
          rel="stylesheet"
        />
        <link
          href="https://fonts.googleapis.com/css2?family=Noto+Color+Emoji&display=swap"
          rel="stylesheet"
        />
      </Head>
      <div className="flex flex-col md:flex-row min-h-screen">
        <BottomNavBar />
        <main className="flex-1 p-4 md:ml-20 md:pt-4">
          <Component {...pageProps} />
        </main>
      </div>
    </>
  );
}

export default MyApp;
