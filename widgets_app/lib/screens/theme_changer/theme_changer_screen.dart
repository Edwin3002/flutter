import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/providers/theme_provider.dart';

class ThemeChangerScreen extends ConsumerWidget {
  static const name = 'theme_changer_screen';

  const ThemeChangerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isDarkmode = ref.watch(themeNotifierProvider).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme changer'),
        actions: [
          IconButton(
              icon: Icon(isDarkmode
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined),
              onPressed: () {
                // ref.read(isDarkmodeProvider.notifier)
                //   .update((state) => !state );
                ref.read(themeNotifierProvider.notifier).toggleDarkMode();
              })
        ],
      ),
      body: const _ThemeChangerView(),
    );
  }
}

class _ThemeChangerView extends ConsumerWidget {
  const _ThemeChangerView();
  @override
  Widget build(BuildContext context, ref) {
    final List<Color> colors = ref.watch(colorListProvider);
    final int selectedColor = ref.watch(themeNotifierProvider).selectedColor;
    // Color colorInput =

    return Column(
      children: [
        SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: colors.length,
            itemBuilder: (context, index) {
              final Color color = colors[index];
              return RadioListTile(
                title: Text('Este color', style: TextStyle(color: color)),
                subtitle: Text('${color.value}'),
                activeColor: color,
                value: index,
                groupValue: selectedColor,
                onChanged: (value) {
                  ref
                      .watch(themeNotifierProvider.notifier)
                      .changeColorIndex(index);
                },
              );
            },
          ),
        ),
        _SliderThemeChange()
      ],
    );
  }
}

class _SliderThemeChange extends StatefulWidget {
  const _SliderThemeChange();

  @override
  State<_SliderThemeChange> createState() => _SliderStateThemeChange();
}

class _SliderStateThemeChange extends State<_SliderThemeChange> {
  int colorRSlider = 0;
  int colorGSlider = 0;
  int colorBSlider = 0;
  int opacitySlider = 1;
  Color colorBg = Color.fromRGBO(150, 150, 150, 100);
  // Color colorBg = Color.fromRGBO(colorRSlider,  colorRSlider, colorRSlider, opacitySlider.toDouble());

  void changeColorBg() => setState(() {
        colorBg = Color.fromRGBO(
            colorRSlider, colorRSlider, colorRSlider, opacitySlider.toDouble());
      });
  @override
  Widget build(BuildContext context) {
    // final Color color = colors[index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        color: colorBg,
        child: Column(
          children: [
            Slider(
                min: 0,
                max: 255,
                activeColor:
                    Color.fromRGBO(colorRSlider, colorGSlider, colorBSlider, 1),
                label: "$colorRSlider",
                value: colorRSlider.toDouble(),
                onChanged: (value) => setState(() {
                      colorRSlider = value.toInt();
                    })),
            Slider(
                min: 0,
                max: 255,
                activeColor:
                    Color.fromRGBO(colorGSlider, colorGSlider, colorBSlider, 1),
                label: "$colorGSlider",
                value: colorGSlider.toDouble(),
                onChanged: (value) => setState(() {
                      colorGSlider = value.toInt();
                    })),
            Slider(
                min: 0,
                max: 255,
                activeColor:
                    Color.fromRGBO(colorBSlider, colorGSlider, colorBSlider, 1),
                label: "$colorBSlider",
                value: colorBSlider.toDouble(),
                onChanged: (value) {
                  colorBSlider = value.toInt();
                  setState(() {});
                }),
            Slider(
                min: 0,
                max: 10,
                divisions: 20,
                activeColor: Color.fromRGBO(
                    colorRSlider, 200, 56, opacitySlider.toDouble()),
                label: "$opacitySlider",
                value: opacitySlider.toDouble(),
                onChanged: (value) {
                  opacitySlider = value.toInt();
                  setState(() {});
                }),
            Text(
              "$colorRSlider $colorGSlider $colorBSlider",
              style: TextStyle(
                  color: Color.fromRGBO(
                      colorRSlider, colorRSlider, colorRSlider, 1),

                  // color: Color.fromRGBO(229, 166, 207, 1),
                  fontSize: 20),
            ),
            FloatingActionButton(
                onPressed: changeColorBg, backgroundColor: Colors.amber

                // backgroundColor: Color.fromRGBO(colorRSlider,  colorRSlider, colorRSlider, opacitySlider.toDouble())
                )
          ],
        ),
      ),
    );
  }
}
