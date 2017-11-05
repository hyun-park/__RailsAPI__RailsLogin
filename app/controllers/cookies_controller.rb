class CookiesController < ApplicationController
  def index
    # 쿠키로 회원을 인증하는 로직
    # 직접 회원정보를 입력해서 보냈거나
    # 자동으로 쿠키에 있는 회원정보다 전달됬는지 확인
    if @user = User.find_by(username: params[:username])|| 
      @user = User.find_by(username: cookies[:username])
       
      # 비밀번호를 인증하는 과정
      # 일치하면 true / 틀리면 false
      if @user.authenticate(params[:password])|| 
        @user.authenticate(cookies[:password])
        
        # ★★★★★★★★★★★★★★★★★★★★★★
        # 회원이 직접 입력해서 한 로그인일 경우
        # 아이디와 비밀번호를 쿠키로 세팅하시오.
        # ★★★★★★★★★★★★★★★★★★★★★★
      
        # JSON으로 응답할 메세지에 success 메세지 담기
        @msg = {
          message: "success",
          user: @user
        }
      
      # 아이디는 일치했지만 비밀번호가 틀린 경우
      else
        @msg = {
          message: "wrong password"
        }
      end
      
    #해당 아이디가 없을 경우
    else
      @msg = {
        message: "No user"
      }
    end
    
    # 로그인이 성공했건 실패했건 msg를 JSON으로 응답
    render json: @msg
  end
end
