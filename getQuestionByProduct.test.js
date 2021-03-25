import http from 'k6/http';
export default function () {
  var url = 'http://localhost:3000';
  http.get(url);
}