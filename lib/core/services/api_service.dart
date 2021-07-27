import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';

import '../utils/constants.dart';

class ApiService extends GetxService {
  String? apiKey;
  String? apiEndpoint;
  SupabaseClient? client;

  @override
  void onInit() {
    apiKey = dotenv.env[API_KEY];
    apiEndpoint = dotenv.env[API_URL];
    client = SupabaseClient(apiEndpoint!, apiKey!);
    super.onInit();
  }
}
