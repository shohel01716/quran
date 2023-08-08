import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../blocs/export_blocs.dart';
import '../utils/export_utils.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Center(
                    child: Container(
                        width: 250.w,
                        height: 70.h,
                        margin: EdgeInsets.all(10.0.h),
                        padding: EdgeInsets.all(10.0.h),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.settings, color: Colors.green),
                            SizedBox(width: 15.0.w),
                            Text("Settings",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(fontWeight: FontWeight.w500)),
                          ],
                        ))),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Ukuran Text Al-Qur'an"),
                    BlocBuilder<TextSizeAlquranBloc, TextSizeAlquranState>(
                      builder: (context, state) {
                        return DropdownButton(
                          isDense: false,
                          value: (state as TextSizeAlquran).selectedValue ??
                              'kecil',
                          hint: const Text("Select Size Text"),
                          items: const [
                            DropdownMenuItem(
                                value: 'kecil', child: Text("Kecil")),
                            DropdownMenuItem(
                                value: 'normal', child: Text("Normal")),
                            DropdownMenuItem(
                                value: 'besar', child: Text("Besar")),
                          ],
                          onChanged: (value) {
                            context
                                .read<TextSizeAlquranBloc>()
                                .add(ChangedSizeText(value.toString()));
                          },
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                const SizedBox(height: 10),
                BlocConsumer<NotificationChangerBloc, NotificationChangerState>(
                  listener: (context, state) {
                    if ((state as NotificationChangerSwitch).notification ==
                        true) {
                      // context
                      //     .read<AdzanTimeBloc>()
                      //     .add(const NotificationAdzan());
                    }
                    if (state is NotificationChangerError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: const Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                          padding: EdgeInsets.all(5.h),
                          margin: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 5.w),
                          elevation: 2,
                          showCloseIcon: true,
                          backgroundColor: AppColors.cardBackgroundColor,
                          content: Text(
                              (state as NotificationChangerError).error,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium)));
                    }
                  },
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Matikan Notifikasi Adzan"),
                        CupertinoSwitch(
                          value:
                              (state as NotificationChangerSwitch).notification,
                          onChanged: (value) {
                            context
                                .read<NotificationChangerBloc>()
                                .add(NotificationChangerSwitchEvent(value));
                          },
                        )
                      ],
                    );
                  },
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                              child: Container(
                                  width: 320.w,
                                  padding: EdgeInsets.all(8.0.h),
                                  decoration: BoxDecoration(
                                      color: AppColors.scafoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                          width: 1,
                                          color:
                                              AppColors.cardBackgroundColor)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                          child: Text(
                                        "Do'a",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      )),
                                      const SizedBox(height: 20.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 300.w,
                                            child: Text(
                                              "Ayat",
                                              textAlign: TextAlign.end,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15.0),
                                      Text(
                                        "Latin",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      const SizedBox(height: 10.0),
                                      Text("Artinya",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                      const SizedBox(height: 20.0),
                                      Center(
                                        child: TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text("Back")),
                                      )
                                    ],
                                  )));
                        },
                      );
                    },
                    icon: const Icon(Icons.arrow_right))
              ],
            )),
      ),
    );
  }
}
