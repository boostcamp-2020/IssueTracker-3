import { useEffect, useState } from "react";
import axios from "axios";

function useRequest(url) {
  // loading, response, error 값을 다루는 hooks
  const [loading, setLoading] = useState(false);
  const [response, setResponse] = useState(null);
  const [error, setError] = useState(null);

  // 렌더링 될 때, 그리고 url 이 바뀔때만 실행됨
  useEffect(
    async () => {
      setError(null); // 에러 null 처리
      try {
        setLoading(true); // 로딩중
        const res = await axios.get(url); // 실제 요청
        setResponse(res); // response 설정
      } catch (e) {
        setError(e); // error 설정
      }
      setLoading(false); // 로딩 끝
    },
    [url] // url 이 바뀔때만 실행됨
  );
  return [response, loading, error]; // 현재 값들을 배열로 반환
}

export default useRequest;
