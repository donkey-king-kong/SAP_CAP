namespace my.bookshop;

entity Books {
  key ID : Integer;
  title  : String;
  author : String;
  price  : Decimal(9,2);
}
