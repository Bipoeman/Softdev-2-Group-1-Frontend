import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  final VoidCallback? onBackPressed;
  final ValueChanged<double>? onMasterVolumeChanged;
  final ValueChanged<double>? onBgmVolumeChanged;
  final ValueChanged<double>? onSfxVolumeChanged;

  const Settings({
    super.key,
    this.onBackPressed,
    this.onMasterVolumeChanged,
    this.onBgmVolumeChanged,
    this.onSfxVolumeChanged,
    required this.masterVolume,
    required this.bgmVolume,
    required this.sfxVolume,
  });
  final double masterVolume;
  final double bgmVolume;
  final double sfxVolume;

  static const id = 'Settings';

  @override
  _SettingsState createState() => _SettingsState(
      masterVolume: masterVolume * 100,
      sfxVolume: sfxVolume * 100,
      bgmVolume: bgmVolume * 100);
}

class _SettingsState extends State<Settings> {
  late double masterVolume;
  late double bgmVolume;
  late double sfxVolume;

  _SettingsState(
      {required this.masterVolume,
      required this.bgmVolume,
      required this.sfxVolume});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Settings',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            _buildSlider(
              value: masterVolume,
              onChanged: (value) {
                setState(() {
                  masterVolume = value;
                });
                if (widget.onMasterVolumeChanged != null) {
                  widget.onMasterVolumeChanged!(value);
                }
              },
              label: 'Master Volume',
            ),
            _buildSlider(
              value: bgmVolume,
              onChanged: (value) {
                setState(() {
                  bgmVolume = value;
                });
                if (widget.onBgmVolumeChanged != null) {
                  widget.onBgmVolumeChanged!(value);
                }
              },
              label: 'BGM Volume',
            ),
            _buildSlider(
              value: sfxVolume,
              onChanged: (value) {
                setState(() {
                  sfxVolume = value;
                });
                if (widget.onSfxVolumeChanged != null) {
                  widget.onSfxVolumeChanged!(value);
                }
              },
              label: 'SFX Volume',
            ),
            const SizedBox(height: 20),
            IconButton(
              onPressed: widget.onBackPressed,
              icon: const Icon(Icons.arrow_back),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider({
    required double value,
    required ValueChanged<double> onChanged,
    required String label,
  }) {
    return Column(
      children: [
        Text(label),
        Slider(
          value: value,
          onChanged: onChanged,
          min: 0,
          max: 100,
          divisions: 100,
          label: value.round().toString(),
        ),
      ],
    );
  }
}
