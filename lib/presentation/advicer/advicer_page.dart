import 'package:advicer/presentation/advicer/widgets/advice_field.dart';
import 'package:advicer/application/advicer/advicer_bloc.dart';
import 'package:advicer/presentation/advicer/widgets/custom_button.dart';
import 'package:advicer/presentation/advicer/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvicerPage extends StatelessWidget {
  const AdvicerPage({super.key});

  @override
  Widget build(BuildContext context) {

    final blocProvider = BlocProvider.of<AdvicerBloc>(context);
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Advicer", style: themeData.textTheme.displayLarge),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: BlocBuilder<AdvicerBloc, AdvicerState>(
                    bloc: blocProvider,
                    builder: (context, advicerState) {
                      if (advicerState is AdvicerInitial) {
                        return Text(
                          "Your Advice is waiting for you!",
                          style: themeData.textTheme.displayLarge,
                        );
                      } else if (advicerState is AdvicerStateLoading) {
                        return CircularProgressIndicator(
                          color: themeData.colorScheme.secondary,
                        );
                      } else if (advicerState is AdvicerStateLoaded) {
                        return AdviceField(advice: advicerState.advice);
                      } else if (advicerState is AdvicerStateError) {
                        return ErrorMessage(message: advicerState.message);
                      }
                      return Placeholder();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: Center(
                  child: CustomButton(
                    onPressed: () {
                      blocProvider.add(AdviceRequestedEvent());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
