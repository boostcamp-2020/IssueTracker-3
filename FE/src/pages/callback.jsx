import { useEffect } from 'react';
import axios from 'axios';
import qs from 'qs';

function Callback({ history, location }) {

  useEffect(() => {
    async function getToken() {
      const { code } = qs.parse(location.search, {
        ignoreQueryPrefix: true,
      });

      try {
        // 이 부분은 express에 요청하여 JWT 토큰을 발급합니다.
        const { jwt } = await axios.post(`http://101.101.210.34:3000/auth/github/web`, {
          code,
        });
        console.log(jwt);

        // 유저 JWT 토큰을 저장합니다.
        localStorage.setItem('jwt', jwt);
        history.push('/'); // 로그인이 완료되면 보여줄 페이지
      } catch (error) {
        history.push('/error'); // api요청이 실패했을때 애러 핸들링 페이지
      }
    }

    getToken();
  }, [location, history]);
  return null; // 이 부분에 로딩바와 같은 페이지를 렌더링 해도 좋아요.
}

export default Callback;