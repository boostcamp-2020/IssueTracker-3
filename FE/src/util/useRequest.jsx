import axios from "axios";
import { useEffect, useState } from "react";

const HOST_ADDRESS = "http://101.101.210.34:3000";

function useRequest(url, method, data = null) {
  const [loading, setLoading] = useState(false);
  const [response, setResponse] = useState(null);
  const [error, setError] = useState(null);

  useEffect(
    async () => {
      setError(null); 
      try {
        setLoading(true); 
        const res = await axios({
          baseURL: HOST_ADDRESS,
          method,
          url,
          data,
        });
        setResponse(res); 
      } catch (e) {
        setError(e); 
      }
      setLoading(false); 
    },
    [url] 
  );
  return [response, loading, error]; 
}

export default useRequest;