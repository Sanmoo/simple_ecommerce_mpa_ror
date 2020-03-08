function request(url, method) {
  const token = document.querySelectorAll('meta[name=csrf-token]')[0].getAttribute('content');
  return new Promise((resolve, reject) => {
    return fetch(url, {
      method,
      headers: { 'X-CSRF-Token': token }
    }).then((e) => {
      if (e.status === 204) {
        return resolve();
      }
      if (e.status >= 200 && e.status <= 300) {
        return resolve(e.json());
      }
      throw reject(e);
    });
  });
}

window.post = (url) => request(url, 'POST');
window.patch = (url) => request(url, 'PATCH');
window.get = (url) => request(url, 'GET');
window.deleteReq = (url) => request(url, 'DELETE');
