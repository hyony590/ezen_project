package second.sosu.chat;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import second.sosu.message.service.MessageService;

@Component
public class ChatHandler extends TextWebSocketHandler {
   private static List<WebSocketSession> list = new ArrayList<WebSocketSession>();
   @Resource(name="messageService")
   private MessageService messageService;
      
   //클라이언트 접속
   @Override
   public void afterConnectionEstablished(WebSocketSession webSession) throws Exception {
      list.add(webSession);
   }

   @Override
   protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
      String msg = message.getPayload();
      
      String[] msgcut = msg.split(",");
      
      Map<String,Object> messageMap = new HashMap<>();
      messageMap.put("MSG_CONTENT", msgcut[0]);
      messageMap.put("MSG_SENDER", msgcut[1]);
      messageMap.put("MSG_RECIVER", msgcut[2]);
      messageMap.put("MSG_ROOM", msgcut[3]);
      
      messageService.messageInsert(messageMap);
      
      for (WebSocketSession s : list) {
         if(s.getUri().equals(session.getUri())) {
              s.sendMessage(new TextMessage(msgcut[0] + "," +(msgcut[1])));
         }else {
            if(s.getId().equals(session.getId())) {
            	s.sendMessage(new TextMessage(msgcut[0] + "," +(msgcut[1])));
            }
         }
      }
   }
   
   // 클라이언트의 접속이 해제 호출 메소드
   @Override
   public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
      list.remove(session);
   }
}