abstract class PrayerStates {}

class PrayerInitialState extends PrayerStates {}

class PrayerGetPrayerSuccessState extends PrayerStates {}

class PrayerGetPrayerErrorState extends PrayerStates {}

class PrayerGetLocationSuccessState extends PrayerStates {}

class PrayerGetLocationErrorState extends PrayerStates {}

class PrayerGetCoordinatesSuccessState extends PrayerStates {}

class PrayerIncrementState extends PrayerStates {}

class PrayerSearchState extends PrayerStates {}

class PrayerDecrementState extends PrayerStates {}

class PrayerGetCoordinatesErrorState extends PrayerStates {}

class PrayerFavoritesState extends PrayerStates {}

class CheckPrayerFavoritesState extends PrayerStates {}

class PrayerFavoritesSearchState extends PrayerStates {}

class PrayerGetLoadingState extends PrayerStates {}
