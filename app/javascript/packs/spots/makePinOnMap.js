window.makePinOnMap = function (elementMap) {
  geocoder.geocode({ 'address': elementMap.getAttribute("value") }, function (results, status) {
    console.log(elementMap.getAttribute("value"))
    //該当する検索結果がヒットした時に、地図の中心を検索結果の緯度経度に更新する
    if (status == 'OK') {
      var opts = {
        zoom: 13,
        center: results[0].geometry.location
      };
      map = new google.maps.Map(elementMap, opts);
      marker = new google.maps.Marker({
        map: map,
        position: results[0].geometry.location
      });
    } else {
      //検索結果が何もなかった場合に表示
      alert('該当する結果がありませんでした：' + status);
    }
  });
}