import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_mistralai/langchain_mistralai.dart';
import 'package:langchain_supabase/langchain_supabase.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:yourfit/src/services/models/index.dart';
import '../../utils/env/env.dart';

@singleton
class FitnessLLMService {
  late Runnable llm;

  late String formatInstructions;

  late BasePromptTemplate systemPrompt;

  @postConstruct
  void init() async {
    try {
      formatInstructions = """
    "You must format your output as a JSON value that adheres to a given "JSON Schema" instance.
    JSON Schema" is a declarative language that allows you to annotate and validate JSON documents.
    For example, the example "JSON Schema" instance {{"properties": {{"foo": {{"description": "a list of test words", "type": "array", "items": {{"type": "string"}}}}}}, "required": ["foo"]}}}}
    would match an object with one required property, "foo". The "type" property specifies "foo" must be an "array", and the "description" property semantically describes it as "a list of test words". The items within "foo" must be strings.
    Thus, the object {{"foo": ["bar", "baz"]}} is a well-formatted instance of this example "JSON Schema". The object {{"properties": {{"foo": ["bar", "baz"]}}}} is not well-formatted.
    Your output will be parsed and type-checked according to the provided schema instance, so make sure all fields in your output match the schema exactly and there are no trailing commas!
    'Here is the JSON Schema instance your output must adhere to. Include the enclosing markdown codeblock:\n' +
    ```json
    '{"type":"array","items":{"type":"object","properties":{"day":{"type":"string","description":"This is the day in which the exercises should be preformed"},"totalCaloriesBurned":{"type":"number", "description":"This is the total number of calories this day will burn. This is a sum of calories from the "exercises" array."},"exercises":{"type":"array","items":{"type":"object","properties":{"name":{"type":"string","description":"This is the name of the exercise to be performed"},"instructions":{"type":"string","description":"This is the short instruction on how to preform the exercise and things to know beforehand"},"category":{"type":"string","description":"This is the category of the exercise. cardio, strength, strongman, olympic_weightlifting etc."},"intensity":{"type":"number","description":"This is the intensity of the exercise. It is an integer value ranging from 1-3."},"calories_burned":{"type":"number","description":"This is the amount of calories this exercise will burn. This is a exact number value calculated using the MET formula that depicts the amount of calories an exercise will burn"},"duration":{"type":"string","description":"The duration of the exercise. This is an exact value such as 13m or 1h"}},"required":["name","instructions","category","intensity","calories_burned","duration"],"additionalProperties":false},"description":"This is a json array of exercises to be completed for this day"}},"required":["day","exercises","totalCaloriesBurned"],"additionalProperties":false,"description":"This is a json object containing a exercises and day properties."},"\$schema":"http://json-schema.org/draft-07/schema#"}'"
    ```""";

      systemPrompt = ChatPromptTemplate.fromPromptMessages([
        ChatMessagePromptTemplate.system(
          "---- Instructions ----\nYou are a thoughtful, detailed, accurate, and considerate fitness trainer who always provides the user with the appropriate exercise(s) to perform at their age, height, weight, and potentially level of fitness/equipment availability. You are also a excellent at math which enables you to give out mathematically correct numbers and calculations when necessary. Your response should only be related to the given information provided to you by the user and relevant informative information found in the knowledgebase. Your response should also only contain the information necesssary and should contain no introduction or explanation, only valid JSON that can be parsed. ---- Context ----\n{context}\n\n ---- Format Instructions ----\n{format_instructions}\n\nBelow is the information you will take into consideration when formualating your response.\n----User Information----\nage:{age}\nheight:{height}\nweight:{weight}\noptionalParameters:{optionalParameters}\n user_input:{input}",
        )
      ]);

      var vectorStore = Supabase(
          tableName: "documents",
          supabaseUrl: Env.supabaseUrl,
          supabaseKey: Env.supabaseKey,
          embeddings: MistralAIEmbeddings(
            apiKey: Env.mistralKey,
            model: "mistral-embed",
          ));

      var model = systemPrompt |
          ChatOpenAI(
            apiKey: Env.groqKey,
            baseUrl: "https://api.groq.com/openai/v1",
            defaultOptions: const ChatOpenAIOptions(
              model: "llama-3.1-70b-versatile",
            ),
          );

      llm = Runnable.fromMap({
            "context": Runnable.getItemFromMap("input") |
                (vectorStore.asRetriever() |
                    Runnable.mapInput((docs) => docs.join("\n"))),
            "format_instructions":
                Runnable.getItemFromMap("format_instructions"),
            "optionalParameters": Runnable.getItemFromMap("optionalParameters"),
            "age": Runnable.getItemFromMap("age"),
            "height": Runnable.getItemFromMap("height"),
            "weight": Runnable.getItemFromMap("weight"),
            "input": Runnable.getItemFromMap("input")
          }) |
          model |
          StringOutputParser();
    } catch (e) {
      print(e);
    }
  }

  Future<String?> invoke(
    Map<String, dynamic> params, {
    required Function(Exception) onError,
  }) async {
    try {
      var result = (await llm.invoke({
        "format_instructions": formatInstructions,
        ...params,
      })) as String;
      print(result);
      return result;
    } on Exception catch (e) {
      onError(e);
    }
    return null;
  }

  Future<String?> invokeWithUser(
    UserData user,
    String input, {
    required Function(Exception) onError,
    String optionalParameters = "",
  }) async =>
      await invoke({
        "age": user.age,
        "weight": user.weight,
        "height": user.height,
        "optionalParameters": optionalParameters,
        "input": input
      }, onError: onError);

  Map<String, dynamic> responseToJson(String response) =>
      jsonDecode(response.replaceAll("```json", "").replaceAll("```", "")[0]);
}
