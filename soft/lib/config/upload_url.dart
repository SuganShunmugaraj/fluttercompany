class BaseUrl{
  static String baseUrl = "http://192.168.1.102:3000/";
  static String contacts = baseUrl + "api/client/";
  static String login = baseUrl + "api/company/login";
   static String invoice = baseUrl + "api/invoices/getnonrecurringinvoice/";
   static String category = baseUrl + "api/category/";
    static String subCategory = baseUrl + "api/subcategory/";
    static String service = baseUrl + "api/service/";
    static String payment = baseUrl + "api/accounts/";
    static String addInvoice = baseUrl + "api/invoices/";
    static String getInvoice = baseUrl + "api/accounts/getinvoice/";
}