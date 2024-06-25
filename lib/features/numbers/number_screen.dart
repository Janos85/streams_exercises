import 'package:flutter/material.dart';
import 'package:streams_exercises/features/numbers/number_repository.dart';

class NumberScreen extends StatelessWidget {
  const NumberScreen({
    super.key,
    required this.numberRepository,
  });

  final NumberRepository numberRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Screen'),
      ),
      body: StreamBuilder<List<int>>(
        stream: numberRepository.getNumberStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No numbers available'));
          } else {
            final numbers = snapshot.data!;
            return ListView.builder(
              itemCount: numbers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(numbers[index].toString()),
                );
              },
            );
          }
        },
      ),
    );
  }
}
