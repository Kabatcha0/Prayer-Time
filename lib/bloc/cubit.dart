import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:prayer/bloc/states.dart';
import 'package:prayer/models/prayer_time_model.dart';
import 'package:prayer/shared/network/network.dart';

class PrayerCubit extends Cubit<PrayerStates> {
  PrayerCubit() : super(PrayerInitialState());
  static PrayerCubit get(context) => BlocProvider.of(context);
  Map countryAndCity = {
    "cario": "Egypt",
    "paris": "france",
    "Roma": "italy",
    "Moscow": "russia",
    "London": "UnitedKingdom",
    "berlin": "Germany",
  };
  List prayer = [
    "Fajr",
    "Duhur",
    "Asr",
    "Maghrib",
    "Isha",
  ];
  Map favorite = {};
  void checkPrayer() {
    countryAndCity.keys.toList().forEach((element) {
      favorite.addAll({element: false});
      emit(CheckPrayerFavoritesState());
    });
  }

  List favoritesOfCity = [];
  void saveCountry(String city) {
    if (favoritesOfCity.contains(city)) {
      favorite.update(city, (value) => false);
      favoritesOfCity.remove(city);

      emit(PrayerFavoritesState());
    } else {
      favorite.addAll({city: true});
      favoritesOfCity.add(city);
      emit(PrayerFavoritesState());
    }
  }

  void saveCountrySearch(String city) {
    if (favoritesOfCity.contains(city)) {
      favorite.update(city, (value) => false);
      favoritesOfCity.remove(city);

      emit(PrayerFavoritesSearchState());
    } else {
      favorite.addAll({city: true});
      favoritesOfCity.add(city);
      emit(PrayerFavoritesSearchState());
    }
  }

  // List<String> cityOfSearch = ["Cairo", "London", "Paris", "Roma", "Berlin",
  // "Moscow"
  // ];

  List search = [];
  PrayerTime? prayerTime;
  Position? position;
  LocationPermission? permission;
  String? city;
  String? country;
  String? cityOfPrayer;
  String? countryOfPrayer;
  List<Placemark> placemark = [];
  void searchItem({required String text}) {
    search = [];

    countryAndCity.keys.toList().forEach((element) {
      if (element.startsWith(text)) {
        search.add(element);
        log("$search");

        emit(PrayerSearchState());
      }
    });
  }

  void coordinates({
    required double lat,
    required double lon,
  }) {
    placemarkFromCoordinates(lat, lon).then((value) {
      placemark = value;
      city = placemark[0].subAdministrativeArea;
      country = placemark[0].country;
      emit(PrayerGetCoordinatesSuccessState());
    }).catchError((e) {
      log(e.toString());
    });
  }

  void currentLocation({
    required String city,
    required String country,
  }) {
    Geolocator.requestPermission().then((value) {
      permission = value;
      Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).then((value) {
        position = value;
        coordinates(lat: position!.latitude, lon: position!.longitude);
        getPrayerTime(
          city: city,
          country: country,
        );
      }).catchError((e) {
        log(e.toString());
        emit(PrayerGetLocationErrorState());
      });
    });
  }

  int index = int.parse(DateFormat.d().format(DateTime.now())) - 1;
  //  int.parse(m.Jiffy.now().format(pattern: "d"));
  int indexOfMonth = int.parse(DateFormat.M().format(DateTime.now()));
  void swipePlus() {
    if (index < 29) {
      index++;
      emit(PrayerIncrementState());
    }
    if (index == 29) {
      indexOfMonth++;
      index = 0;
      getPrayerTime(city: cityOfPrayer!, country: countryOfPrayer!);
      emit(PrayerIncrementState());
    }
  }

  void swipeMinus() {
    if (index > 0) {
      index--;
    }
    emit(PrayerDecrementState());
  }

  List timeOfPrayer = [];
  void getPrayerTime({
    required String city,
    required String country,
  }) {
    emit(PrayerGetLoadingState());
    DioHelper.getData(
            path: "${DateFormat.y().format(DateTime.now())}/$indexOfMonth",
            // "${m.Jiffy.now().format(pattern: "yyyy")}/$indexOfMonth",
            city: city,
            country: country,
            method: 2)
        .then((value) {
      prayerTime = PrayerTime.fromJson(value.data);
      log("message");
      cityOfPrayer = city;
      countryOfPrayer = country;

      emit(PrayerGetPrayerSuccessState());
    }).catchError((e) {
      log(e.toString());
      emit(PrayerGetPrayerErrorState());
    });
  }
}
