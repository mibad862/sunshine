import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sunshine_app/controller/brightness_controller.dart';
import 'package:sunshine_app/controller/theme_controller.dart';
import 'package:sunshine_app/controller/visibility_controller.dart';

class Footer extends StatefulWidget {
  const Footer({super.key, required this.isShowSettings});
  final bool isShowSettings;

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  void initState() {
    super.initState();
    final pro = Provider.of<BrightnessController>(context, listen: false);
    pro.getCurrentBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VisibilityController>(
      builder: (context, visibilityValue, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Consumer<ThemeController>(
            builder: (context, themeValue, child) => Row(
              children: [
                IconButton(
                  onPressed: () =>
                      themeValue.toggleTheme(theme: ThemeMode.dark),
                  icon: const Icon(
                    Icons.nightlight_round_rounded,
                    size: 45,
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      themeValue.toggleTheme(theme: ThemeMode.light),
                  icon: const Icon(
                    Icons.sunny,
                    size: 45,
                  ),
                ),
                IconButton(
                  onPressed: () => visibilityValue.toggleVisibility(),
                  icon: Icon(
                    visibilityValue.isVisible
                        ? LineIcons.eye
                        : LineIcons.eye_slash,
                    size: 45,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.sunny,
                size: 30,
              ),
              Consumer<BrightnessController>(
                builder: (context, brightnessController, child) => Slider(
                  value: brightnessController.currentBrightness,
                  min: 0.0,
                  max: 1.0,
                  divisions: 100,
                  label: (brightnessController.currentBrightness * 100)
                      .round()
                      .toString(),
                  onChanged: (double value) {
                    brightnessController.setBrightness(value);
                  },
                ),
              ),
              const Icon(
                Icons.sunny,
                size: 50,
              ),
            ],
          ),
          if (widget.isShowSettings) ...[
            Container(
                height: 50.0,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.orange)),
                alignment: Alignment.center,
                child: const Text(
                  'SETTINGS',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ] else ...[
            const SizedBox()
          ]
        ],
      ),
    );
  }
}
