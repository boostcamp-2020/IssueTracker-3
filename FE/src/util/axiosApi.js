import axios from "axios";

const HOST_ADDRESS = "http://101.101.210.34:3000";

const axiosApi = async (url, method, data = null) => {
  const res = await axios({
    baseURL: HOST_ADDRESS,
    method,
    url,
    data,
    headers: {
      Authorization: `Bearer ${localStorage.getItem("token")}`,
    },
  });
  return res;
};

export default axiosApi;
