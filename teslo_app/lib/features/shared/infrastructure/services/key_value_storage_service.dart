abstract class KeyValueStorageService {

//generico, me dice el tipo dependiendo el q reciba, pa q no diga dynamic
Future<void> setValueKey<T>(String key, T value);
Future<T?> getValueKey<T>(String key);
Future<bool> removeKey(String key);



  
}