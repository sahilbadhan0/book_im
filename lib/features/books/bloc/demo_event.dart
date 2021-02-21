

//Event Events
abstract class BooksEvent {
  const BooksEvent();
}

//Fetch Event list
class FetchBooks extends BooksEvent {
  FetchBooks({currentPage});
}

//create new post
