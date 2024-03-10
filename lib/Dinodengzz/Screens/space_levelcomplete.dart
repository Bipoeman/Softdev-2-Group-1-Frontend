import 'package:end_credits/end_credits.dart';
import 'package:flutter/material.dart';

class LevelCompleteBoss extends StatelessWidget {
  final VoidCallback onExitPressed;

  const LevelCompleteBoss({
    required this.onExitPressed,
    super.key,
  });

  static const id = 'LevelCompleteBoss';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: EndCredits(
              [
                Section(title: 'Developer', roles: [
                  Role(name: 'Role 1', crew: [const Responsable('John Doe')]),
                  Role(name: 'Role 2', crew: [const Responsable('John Doe')]),
                  Role(name: 'Role 3', crew: [const Responsable('John Doe')]),
                  Role(name: 'Role 4', crew: [const Responsable('John Doe')]),
                  Role(name: 'Role 5', crew: [const Responsable('John Doe')]),
                ]),
                Section(title: 'Producers', roles: [
                  Role(name: 'Executive producer', crew: [
                    const Responsable('John Doe'),
                    const Responsable('John Doe'),
                    const Responsable('John Doe')
                  ]),
                  Role(name: 'Producer', crew: [
                    const Responsable('John Doe'),
                    const Responsable('John Doe'),
                    const Responsable('John Doe')
                  ])
                ]),
                Section(title: 'Other', roles: [
                  Role(name: 'Role', crew: [
                    const Responsable('John Doe'),
                    const Responsable('John Doe'),
                    const Responsable('John Doe'),
                    const Responsable('John Doe')
                  ])
                ])
              ],
              curve: Curves.linear,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.012,
            right: MediaQuery.of(context).size.width * 0.036,
            child: GestureDetector(
              onTap: onExitPressed,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.skip_next,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.height * 0.04,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
