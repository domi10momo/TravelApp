const initMap = (async () => {
  let map
  let geocoder
  const inputMap = document.getElementById("map");
  const opts = {
    zoom: 12.5,
    center: new google.maps.LatLng(37.9120388, 139.061775)
  };
  const url = gon.map_url;

  const json = await fetch(url)
    .then(res => {
      return res.json()
    }).catch(error => {
      console.error("これは非同期処理失敗時のメッセージ", error)
      return null
    });
  console.log(json)

})();