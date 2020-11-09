import { resMessage } from "@interfaces/response";

const makeResponse = (statusCode: number, message: string): resMessage => {
  return {
    message,
    httpcode: statusCode,
  };
};

export default makeResponse;
