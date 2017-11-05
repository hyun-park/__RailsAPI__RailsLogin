class SessionsController < ApplicationController
  def index
    # 세션으로 회원을 인증하는 로직
    # 유저가 직접 회원정보를 입력해서 보냈거나
    # 세션에 회원정보가 저장되어 있으면 이를 이용해서 확인
    if @user = User.find_by(username: params[:username])|| 
      @user = User.find_by(username: session[:username])
      
      if @user.authenticate(params[:password])|| 
        @user.authenticate(session[:password])
        
        # ★★★★★★★★★★★★★★★★★★★★★★
        # 회원이 직접 입력해서 한 로그인일 경우
        # 아이디와 비밀번호를 세션에 저장하시오.
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
  
  # 서버에서 세션을 삭제하는 메서드
  def delete
    reset_session
    
    @msg = {
      message: "Deleted Session!"
    }
      
    # msg를 JSON으로 응답
    render json: @msg
  end
end
