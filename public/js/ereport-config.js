/**
 * Supabase + Edge Function URLs for eReport static pages.
 * Replace placeholders with your project values from the Supabase dashboard.
 */
window.EReportSupabase = {
  url: "https://qppfppgzebfbsnneumau.supabase.co",
  anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFwcGZwcGd6ZWJmYnNubmV1bWF1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQzNzAwMjIsImV4cCI6MjA4OTk0NjAyMn0.4NLVxgph0mSUWHu8jhEzaVjJmNfqxF_mq2GRw12woJY",
  /** Deploy the create-employee function and paste its URL here. */
  createEmployeeFnUrl:
    "https://qppfppgzebfbsnneumau.supabase.co/functions/v1/create-employee",
};

window.ereportSupabaseConfigured = function () {
  const c = window.EReportSupabase;
  if (!c || !c.url || !c.anonKey) return false;
  if (c.url.includes("YOUR_PROJECT")) return false;
  if (c.anonKey.includes("YOUR_PUBLIC")) return false;
  return true;
};

// Singleton Supabase client to avoid multiple instances
window.getSupabaseClient = function () {
  if (!window._supabaseClient) {
    window._supabaseClient = window.supabase.createClient(
      window.EReportSupabase.url,
      window.EReportSupabase.anonKey
    );
  }
  return window._supabaseClient;
};
