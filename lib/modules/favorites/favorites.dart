import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer/bloc/cubit.dart';
import 'package:prayer/bloc/states.dart';

class Favorites extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();

  Favorites({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrayerCubit, PrayerStates>(
      builder: (context, state) {
        var cubit = PrayerCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Column(
              children: [
                Expanded(
                    child: ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        // cubit.getPrayerTime(
                        //     city: cubit.favoritesOfCity[index],

                        //     country: country);
                      },
                      title: Text(
                        cubit.favoritesOfCity[index],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          cubit.saveCountry(cubit.favoritesOfCity[index]);
                        },
                        icon: const Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 24,
                        ),
                      )),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
                  itemCount: cubit.favoritesOfCity.length,
                ))
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is PrayerGetPrayerSuccessState) {
          Navigator.pop(context);
        }
      },
    );
  }
}
