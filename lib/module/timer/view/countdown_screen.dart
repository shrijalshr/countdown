import 'package:countdown/common/const/asset_paths.dart';
import 'package:countdown/common/extensions/app_extensions.dart';
import 'package:countdown/common/helper/app_logger.dart';
import 'package:countdown/widget/scrollable_column.dart';
import 'package:countdown/widget/tap_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widget/app_button.dart';
import '../bloc/bloc/countdown_bloc.dart';
import '../service/counter_service.dart';

class CountdownScreen extends StatelessWidget {
  TextEditingController durationController = TextEditingController();

  CountdownScreen({Key? key}) : super(key: key);
  bool containsOnlyHMS(String string) {
    RegExp regex = RegExp(r"[^hms]+");
    return !regex.hasMatch(string);
  }

  Duration? parseTimeString(String timeString) {
    try {
      final parts = timeString.split(':');
      final parsedParts =
          parts.map((part) => part.replaceAll(RegExp('[^0-9]'), ''));

      int hours = 0;
      int minutes = 0;
      int seconds = 0;

      if (parsedParts.length == 3) {
        hours = int.parse(parsedParts.elementAt(0));
        minutes = int.parse(parsedParts.elementAt(1));
        seconds = int.parse(parsedParts.elementAt(2));
      } else if (parsedParts.length == 2) {
        minutes = int.parse(parsedParts.elementAt(0));
        seconds = int.parse(parsedParts.elementAt(1));
      } else if (parsedParts.length == 1) {
        final part = parsedParts.elementAt(0);

        if (timeString.contains('h')) {
          hours = int.parse(part);
        } else if (timeString.contains('m')) {
          minutes = int.parse(part);
        } else if (timeString.contains('s')) {
          seconds = int.parse(part);
        } else {
          return null; // Invalid format
        }
      } else {
        return null; // Invalid format
      }
      if (!containsOnlyHMS(timeString)) {
        return null;
      }

      return Duration(hours: hours, minutes: minutes, seconds: seconds);
    } catch (e) {
      return null; // Error occurred while parsing the time string
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CountdownBloc(counter: CounterService()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("CountdownScreen"),
        ),
        body: ScrollableColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.fh,
            ),
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                  color: context.color.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      blurStyle: BlurStyle.normal,
                      color: context.color.lightGrey.withOpacity(.2),
                      offset: const Offset(4, 4),
                    ),
                    BoxShadow(
                      blurRadius: 10,
                      blurStyle: BlurStyle.normal,
                      color: context.color.lightGrey.withOpacity(.2),
                      offset: const Offset(-4, 4),
                    ),
                    BoxShadow(
                      blurRadius: 10,
                      blurStyle: BlurStyle.normal,
                      color: context.color.lightGrey.withOpacity(.2),
                      offset: const Offset(-4, -4),
                    ),
                    BoxShadow(
                      blurRadius: 10,
                      blurStyle: BlurStyle.normal,
                      color: context.color.lightGrey.withOpacity(.2),
                      offset: const Offset(4, -4),
                    )
                  ]),
              child: Center(
                child: BlocBuilder<CountdownBloc, CountdownState>(
                  builder: (context, state) {
                    // final durationInSec = context
                    //     .select((CountdownBloc bloc) => bloc.state.duration);

                    final durationInSec = state.duration;

                    Duration duration = Duration(seconds: durationInSec);
                    final int hours = duration.inHours;
                    final int minutes = duration.inMinutes.remainder(60);
                    final int remainingSeconds =
                        duration.inSeconds.remainder(60);

                    final String hoursString = hours.toString().padLeft(2, '0');
                    final String minutesString =
                        minutes.toString().padLeft(2, '0');
                    final String secondsString =
                        remainingSeconds.toString().padLeft(2, '0');
                    print(
                      "${hoursString}h:${minutesString}m:${secondsString}s",
                    );
                    return Text(
                        "${hoursString}h:${minutesString}m:${secondsString}s",
                        style: context.textStyles.headlineLarge);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            BlocBuilder<CountdownBloc, CountdownState>(
              builder: (context, state) {
                AppLogger.logInfo("State of application is : $state");
                return Column(
                  children: [
                    if (state is CountdownInitial ||
                        state is CountdownCompleted)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              flex: 6,
                              child: CountdownField(
                                      durationController: durationController)
                                  .pr(20)),
                          Flexible(
                            flex: 2,
                            child: AppButton(
                              onPressed: () {
                                Duration? dur =
                                    parseTimeString(durationController.text);

                                if (dur == null) {
                                  showGeneralDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    barrierLabel: "warning",
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                AssetPaths.alert,
                                                height: 150,
                                              ),
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Opps!!\n",
                                                      style: context.textStyles
                                                          .headlineLarge
                                                          ?.copyWith(
                                                              color: context
                                                                  .color
                                                                  .errorColor),
                                                    ),
                                                    TextSpan(
                                                        text:
                                                            "INVALID FORMAT.\n",
                                                        style: context
                                                            .textStyles
                                                            .displayMedium
                                                            ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                    const TextSpan(
                                                        text:
                                                            "Please make sure to use one of the following formats:\n\n"),
                                                    TextSpan(
                                                        text:
                                                            "'2h:33m:12s', '12m:14s', '14s', '1h', or '30m'\n\n",
                                                        style: context
                                                            .textStyles
                                                            .displayMedium
                                                            ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                    const TextSpan(
                                                        text:
                                                            "Try again with a valid format.\n\n"),
                                                    const TextSpan(
                                                        text: "Thank you!🤗")
                                                  ],
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ));
                                    },
                                  );
                                  return;
                                }
                                context.read<CountdownBloc>().add(
                                      StartCountdown(duration: dur.inSeconds),
                                    );
                              },
                              label: const Text("Start"),
                            ).pv(32),
                          ),
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state is CountdownRunning ||
                            state is CountdownPaused)
                          CircularButton(
                            icon: Icon(
                              Icons.stop_rounded,
                              size: 36,
                              color: context.color.whiteSmoke,
                            ),
                            onPressed: () {
                              context
                                  .read<CountdownBloc>()
                                  .add(const StopCountdown());
                            },
                          ),
                        const SizedBox(
                          width: 20,
                        ),
                        state is CountdownRunning
                            ? CircularButton(
                                icon: Icon(
                                  Icons.pause_rounded,
                                  size: 36,
                                  color: context.color.whiteSmoke,
                                ),
                                onPressed: () {
                                  context
                                      .read<CountdownBloc>()
                                      .add(const PauseCountdown());
                                },
                              )
                            : state is CountdownPaused
                                ? CircularButton(
                                    icon: Icon(
                                      Icons.play_arrow_rounded,
                                      size: 36,
                                      color: context.color.whiteSmoke,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<CountdownBloc>()
                                          .add(const ResumeCountdown());
                                    },
                                  )
                                : const SizedBox(),
                      ],
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CountdownField extends StatelessWidget {
  const CountdownField({
    super.key,
    required this.durationController,
  });

  final TextEditingController durationController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: TextFormField(
        controller: durationController,
        // validator: (value) {
        //   if (value == null || value.trim() == "") {
        //     return "Please enter time duration.";
        //   }
        //   return null;
        // },
        textInputAction: TextInputAction.done,
        style: context.textStyles.displayMedium,
        decoration: InputDecoration(
          filled: true,
          fillColor: context.color.white,
          label: const Text("Countdown Duration"),
          hintText: "12h:12h:12s",
          hintStyle: context.textStyles.bodyMedium,
          contentPadding: const EdgeInsets.all(12),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: context.color.lightGrey),
              borderRadius: const BorderRadius.all(Radius.circular(30))),
        ),
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  const CircularButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TapEffect(
      isClickable: true,
      child: InkResponse(
        onTap: onPressed,
        radius: 30,
        focusColor: context.color.whiteSmoke,
        hoverColor: context.color.whiteSmoke,
        highlightColor: context.color.whiteSmoke,
        child: CircleAvatar(
            radius: 30,
            backgroundColor: context.color.primaryColor.withOpacity(.7),
            child: icon),
      ),
    );
  }
}
