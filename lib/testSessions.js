// lib/testSessions.js

export const TEST_USER = {
  id: 'user_12345',
  email: 'testuser@example.com',
  name: 'Erika Tester',
};

export const TEST_GOAL = {
  distance: 'half-marathon',
  target_pace: '5:50',
  notes: 'Prepare for race day',
};

export const TEST_SESSIONS = [
  {
    id: 'sess1',
    user_id: 'user_12345',
    date: '2025-06-07',
    distance_km: 7.2,
    duration_sec: 2600, // 43:20
    avg_hr: 152,
  },
  {
    id: 'sess2',
    user_id: 'user_12345',
    date: '2025-06-06',
    distance_km: 4.5,
    duration_sec: 1580, // 26:20
    avg_hr: 140,
  },
  {
    id: 'sess3',
    user_id: 'user_12345',
    date: '2025-06-04',
    distance_km: 10.1,
    duration_sec: 3920, // 1:05:20
    avg_hr: 160,
  },
];

export const TEST_HEART_RATE_TREND = {
  labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
  values: [145, 152, 138, 162, 148, 157, 149],
};