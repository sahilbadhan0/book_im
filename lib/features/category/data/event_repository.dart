import 'package:book_im/features/category/data/model/event.dart';
import 'package:book_im/features/category/data/model/event_response.dart';
import 'package:book_im/network/apiError.dart';
import 'package:book_im/network/api_handler.dart';
import 'package:book_im/network/api_urls.dart';
import 'package:dio/dio.dart';

class CategoryRepository {



  //fetch Event Listing
  Future<CategoryListResponse> fetchEvents() async {
    try {
      var response = await RestClient.dio.get(ApiURL.category );
      if (response.statusCode == 200) {
        var data = response.data;
        CategoryListResponse prayersResponse = CategoryListResponse.fromJson(data);
        return prayersResponse;
      } else {
        throw Exception();
      }


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