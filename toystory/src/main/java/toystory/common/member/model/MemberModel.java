package toystory.common.member.model;

import java.sql.Date;

import lombok.Data;

@Data

public class MemberModel{

   private int m_num;
   private String m_name;
   private String m_email;
   private String m_password;
   private Date m_birth;
   private String m_mobile;
   private String m_phone;
   private String m_zipcode;
   private String m_address1;
   private String m_address2;
   private int m_point;
   private Date m_regdate;
   private String m_rank;
   private String m_adult;
   private String m_note;
   
}

