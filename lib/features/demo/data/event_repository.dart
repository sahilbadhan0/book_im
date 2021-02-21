import 'dart:convert';

import 'package:book_im/features/demo/data/model/event_response.dart';
import 'package:book_im/network/apiError.dart';
import 'package:dio/dio.dart';

class DemoRepository {



  //fetch Event Listing
  Future<EventListResponse> fetchEvents() async {
    try {
   /*   var response = await RestClient.dio.get(ApiURL.getEvents );
      if (response.statusCode == 200) {
        var data = response.data;
        EventListResponse prayersResponse = EventListResponse.fromJson(data);
        return prayersResponse;
      } else {
        throw Exception();
      }*/

    }  catch (e,st) {
      print("Exception $e,$st");

      if(e is DioError && e.type== DioErrorType.RESPONSE){
        print("got api Eorror");
        var data = e.response.data;
        throw ApiException(message:data['message']);

      }else{
        throw e;
      }
    }
  }


}