import 'dart:convert';
import 'package:flutter_js/flutter_js.dart';
import 'package:injectable/injectable.dart';
import '../../utils/constants.dart';
import '../../utils/env/env.dart';

final _exerciseSchema = {
  "type": "array",
  "element": {
    "type": "object",
    "properties": {
      "day": {
        "type": "string",
        "description":
            "This is the day in which the exercises should be preformed"
      },
      "exercises": {
        "type": "array",
        "element": {
          "type": "object",
          "properties": {
            "name": {
              "type": "string",
              "description": "This is the name of the exercise to be performed"
            },
            "instructions": {
              "type": "string",
              "description":
                  "This is the short instruction on how to preform the exercise and things to know beforehand"
            },
            "category": {
              "type": "string",
              "description":
                  "This is the category of the exercise. cardio, strength, strongman, olympic_weightlifting etc."
            },
            "intensity": {
              "type": "number",
              "coerce": true,
              "description":
                  "This is the intensity of the exercise. It is an integer value ranging from 1-3."
            },
            "calories_burned": {
              "type": "string",
              "description":
                  "This is the amount of calories this exercise will burn. This is a string value containing an context-based mathematical expression that results in a accurate approximation of calories burned"
            },
            "duration": {
              "type": "string",
              "description":
                  "The duration of the exercise. This should be in a structured format that can easily be parsed programmatically"
            }
          }
        },
        "description":
            "This is a json array of exercises to be completed for this day"
      }
    },
    "description":
        "This is a json object containing a exercises and day properties."
  }
};

final _model = "llama-3.2-90b-text-preview";

final _env = jsonEncode({
  "mistralKey": Env.mistralKey,
  "groqKey": Env.groqKey,
  "supabaseUrl": Env.supabaseUrl,
  "supabaseKey": Env.supabaseKey
});


class FitnessLLMService {
  JavascriptRuntime jsRuntime = getIt<JavascriptRuntime>();


  void init() async {
    try {
      // Setup channel error handler
      jsRuntime.onMessage("flutter-interop-channel", _errorHandler);

      await jsRuntime.evaluateAsync(
          "await llmInvoker.init(${jsonEncode(_exerciseSchema)},$_model,$_env)");
      print("JS Runtime Init");
      getExercisesForUser();
    } catch (e) {
      print("An occured during initialization $e");
    }
  }

  Future<String> getExercisesForUser() async {
    try {
      String response = (await jsRuntime.evaluateAsync(
             """
              await llmInvoker.invoke({age:15, weight:151, height:"6ft 1", optionalParameters:"", request:"Give exercises for user"})
             """,
              sourceUrl: "llm_invoker.js"))
          .stringResult;
      print(response);
      return response;
    } catch (e) {
      print("An error ocurred while invoking getExercisesForUser $e");
      return "";
    }
  }

  void _errorHandler(dynamic error) {
    var errorObj = jsonDecode(error);
    print("An error occurred over the interop channel $errorObj");
  }
}
