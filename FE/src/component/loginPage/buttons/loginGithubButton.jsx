import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import axiosApi from "@util/axiosApi";

const StyledGithubButton = styled.button`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function GithubButton() {
  const githubLogin = async () => {
    const res = await axiosApi("https://github.com/login/oauth/authorize?client_id=f3f153d6be2389b2b220&redirect_uri=http://101.101.210.34/callback", "GET");
  };
  return (
      <StyledGithubButton><a href="https://github.com/login/oauth/authorize?client_id=f3f153d6be2389b2b220&redirect_uri=http://101.101.210.34/callback">깃허브로 로그인 하기</a> </StyledGithubButton>
  );
}

export default hot(module)(GithubButton);
