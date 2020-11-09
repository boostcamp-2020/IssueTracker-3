import React, { useState } from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import { Switch, Route, withRouter, type, BrowserRouter, ContextRouter, Router, Link } from "react-router-dom";

import LoginPage from "./pages/loginPage";
import IssueListPage from "./pages/issueListPage";
import IssueDetailPage from "./pages/issueDetailPage";
import IssueCreatePage from "./pages/issueCreatePage";
import LabelListPage from "./pages/labelListPage";
import MilestoneCreatePage from "./pages/milestoneCreatePage";
import MilestoneListPage from "./pages/milestoneListPage";
import RegisterPage from "./pages/registerPage";

const StyledContent = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
const App = () => {
  const [user, setUser] = useState({
    id: 0,
    name: "",
    url: "",
  });
  return (
    <StyledContent>
      Content
      <BrowserRouter>
        <Switch>
          <Route
            exact
            path="/"
            render={() => {
              return user.id === 0 ? <LoginPage User={user} setUser={setUser} /> : <IssueListPage />;
            }}
          />
          <Route exact path="/issuelist" component={IssueListPage} />
          <Route exact path="/issuedetail/:id" component={IssueDetailPage} />
          <Route exact path="/issuecreate" component={IssueCreatePage} />
          <Route exact path="/labellist" component={LabelListPage} />
          <Route exact path="/milestonecreate" component={MilestoneCreatePage} />
          <Route exact path="/milestonelist" component={MilestoneListPage} />
          <Route exact path="/register" component={RegisterPage} />
        </Switch>
      </BrowserRouter>
    </StyledContent>
  );
};

export default hot(module)(App);
