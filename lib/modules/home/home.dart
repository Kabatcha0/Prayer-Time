import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer/bloc/cubit.dart';
import 'package:prayer/bloc/states.dart';
import 'package:prayer/components/components.dart';
import 'package:prayer/modules/favorites/favorites.dart';
import 'package:prayer/shared/local/notifactions.dart';

class Home extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();

  Home({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrayerCubit, PrayerStates>(
        builder: (context, state) {
          var cubit = PrayerCubit.get(context);
          if (cubit.prayerTime != null) {
            DateTime dataTime1 = DateTime.now();
            DateTime dateTime2 = DateTime(
                dataTime1.year,
                dataTime1.month,
                dataTime1.day,
                int.parse(cubit.prayerTime!.data[cubit.index].timing.maghrib
                    .split(":")
                    .first
                    .toString()),
                int.parse(cubit.prayerTime!.data[cubit.index].timing.maghrib
                    .split(":")[1]
                    .split(" ")
                    .first
                    .toString()));
            Notifications.showNotification(
                nameOfPrayer: "Magrib",
                body: "صلاة المغرب",
                seconds: dateTime2.difference(dataTime1).inSeconds);
            log("${dateTime2.difference(dataTime1).inSeconds}");

            DateTime dateTimeIsha = DateTime(
                dataTime1.year,
                dataTime1.month,
                dataTime1.day,
                int.parse(cubit.prayerTime!.data[cubit.index].timing.isha
                    .split(":")
                    .first
                    .toString()),
                int.parse(cubit.prayerTime!.data[cubit.index].timing.isha
                    .split(":")[1]
                    .split(" ")
                    .first
                    .toString()));
            Notifications.showNotification(
                nameOfPrayer: "Isha",
                body: "صلاة العشاء",
                seconds: dateTimeIsha.difference(dataTime1).inSeconds);
            log("${dateTimeIsha.difference(dataTime1).inSeconds}");
            log("${cubit.prayerTime!.data[cubit.index].readable.readable}");
          }
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    navigator(context: context, widget: Favorites());
                  },
                  icon: const Icon(
                    Icons.notifications,
                    size: 28,
                  )),
              actions: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Builder(builder: (context) {
                    return InkWell(
                      onTap: () {
                        Scaffold.of(context).showBottomSheet((context) {
                          return StatefulBuilder(
                            builder: (context, setState) => Container(
                              width: double.infinity,
                              color: Colors.deepPurple.withOpacity(0.7),
                              height: 500,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    textFormField(
                                        textEditingController:
                                            textEditingController,
                                        onChanged: (v) {
                                          setState(() {
                                            cubit.searchItem(text: v);
                                          });
                                        }),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                        child: ListView.separated(
                                      itemBuilder: (context, index) =>
                                          Builder(builder: (context) {
                                        return ListTile(
                                          onTap: () {
                                            cubit.currentLocation(
                                                city: cubit.countryAndCity.keys
                                                    .toList()[index],
                                                country: cubit.countryAndCity[
                                                    cubit.countryAndCity.keys
                                                        .toList()[index]]);

                                            Navigator.pop(context);
                                            textEditingController.text = "";
                                          },
                                          title: cubit.search.isEmpty
                                              ? Text(
                                                  cubit.countryAndCity.keys
                                                      .toList()[index],
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                )
                                              : Text(
                                                  cubit.search[index],
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                          trailing: cubit.favorite[cubit
                                                  .countryAndCity.keys
                                                  .toList()[index]]
                                              ? IconButton(
                                                  onPressed: () {
                                                    if (cubit
                                                        .search.isNotEmpty) {
                                                      setState(() {
                                                        cubit.saveCountrySearch(
                                                            cubit
                                                                .search[index]);
                                                      });
                                                    } else {
                                                      setState(() {
                                                        cubit.saveCountry(cubit
                                                            .countryAndCity.keys
                                                            .toList()[index]);
                                                      });
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.notifications,
                                                    color: Colors.white,
                                                    size: 24,
                                                  ),
                                                )
                                              : IconButton(
                                                  onPressed: () {
                                                    if (cubit
                                                        .search.isNotEmpty) {
                                                      setState(() {
                                                        cubit.saveCountrySearch(
                                                            cubit
                                                                .search[index]);
                                                      });
                                                    } else {
                                                      setState(() {
                                                        cubit.saveCountry(cubit
                                                            .countryAndCity.keys
                                                            .toList()[index]);
                                                      });
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons
                                                        .notifications_none_outlined,
                                                    color: Colors.white,
                                                    size: 24,
                                                  ),
                                                ),
                                        );
                                      }),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                        height: 5,
                                      ),
                                      itemCount: cubit.search.isEmpty
                                          ? 5
                                          : cubit.search.length,
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                      },
                      child: state is PrayerGetLoadingState
                          ? Container()
                          : Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  border: Border.all(
                                      color: Colors.white.withOpacity(0.8))),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  cubit.country == null && cubit.city == null
                                      ? const Text(
                                          "Country",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          "${cubit.country!} , ${cubit.city!}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                  const Icon(
                                    Icons.arrow_drop_down_outlined,
                                    color: Colors.white,
                                    size: 25,
                                  )
                                ],
                              ),
                            ),
                    );
                  }),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              cubit.swipeMinus();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 30,
                            )),
                        Column(
                          children: [
                            Image.asset(
                              "assets/mosque.png",
                              height: 250,
                              width: 250,
                              fit: BoxFit.fill,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${cubit.cityOfPrayer} , ${cubit.countryOfPrayer}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            cubit.prayerTime == null
                                ? Container()
                                : Text(
                                    cubit.prayerTime!.data[cubit.index].readable
                                        .readable,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  )
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              cubit.swipePlus();
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 30,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    cubit.prayerTime == null
                        ? Container()
                        : Expanded(
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return listTile(
                                        prayer: cubit.prayer[index],
                                        time: cubit.prayerTime!
                                            .data[cubit.index].timing.fajr
                                            .replaceAll("(GMT)", "AM")
                                            .replaceAll("(BST)", "AM")
                                            .replaceAll("(MSK)", "AM")
                                            .replaceAll("(CET)", "AM")
                                            .replaceAll("(EET)", "AM"));
                                  } else if (index == 1) {
                                    return listTile(
                                        prayer: cubit.prayer[index],
                                        time: cubit.prayerTime!
                                            .data[cubit.index].timing.duhur
                                            .replaceAll("(GMT)", "PM")
                                            .replaceAll("(BST)", "PM")
                                            .replaceAll("(MSK)", "PM")
                                            .replaceAll("(CET)", "PM")
                                            .replaceAll("(EET)", "PM"));
                                  } else if (index == 2) {
                                    return listTile(
                                        prayer: cubit.prayer[index],
                                        time: cubit.prayerTime!
                                            .data[cubit.index].timing.asr
                                            .replaceAll("(GMT)", "PM")
                                            .replaceAll("(BST)", "PM")
                                            .replaceAll("(MSK)", "PM")
                                            .replaceAll("(CET)", "PM")
                                            .replaceAll("(EET)", "PM"));
                                  } else if (index == 3) {
                                    return listTile(
                                        prayer: cubit.prayer[index],
                                        time: cubit.prayerTime!
                                            .data[cubit.index].timing.maghrib
                                            .replaceAll("(GMT)", "PM")
                                            .replaceAll("(BST)", "PM")
                                            .replaceAll("(MSK)", "PM")
                                            .replaceAll("(CET)", "PM")
                                            .replaceAll("(EET)", "PM"));
                                  } else {
                                    return listTile(
                                        prayer: cubit.prayer[index],
                                        time: cubit.prayerTime!
                                            .data[cubit.index].timing.isha
                                            .replaceAll("(GMT)", "PM")
                                            .replaceAll("(BST)", "PM")
                                            .replaceAll("(MSK)", "PM")
                                            .replaceAll("(CET)", "PM")
                                            .replaceAll("(EET)", "PM"));
                                  }
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 10,
                                    ),
                                itemCount: 5),
                          ),
                    const Text(
                      "Prayer App",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 25,
                    )
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
