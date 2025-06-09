int getMaxHeartRate(int age, String gender) =>
    gender == 'female' ? 226 - age : 220 - age;

double getVocPercentage(int heartRate, int maxHR) => (heartRate / maxHR) * 100;

bool isInTargetZone(int heartRate, int maxHR) =>
    heartRate >= maxHR * 0.65 && heartRate <= maxHR * 0.85;
