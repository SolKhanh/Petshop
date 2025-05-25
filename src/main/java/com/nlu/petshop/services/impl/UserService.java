package com.nlu.petshop.services.impl;

import com.nlu.petshop.entity.AdminRole;
import com.nlu.petshop.entity.UserAccount;
import com.nlu.petshop.repository.AdminRoleRepository;
import com.nlu.petshop.repository.UserAccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserAccountRepository userRepo;

    @Autowired
    private AdminRoleRepository roleRepo;

    public UserAccount getUserDetail(String id){
        return userRepo.findById(id).orElse(null);
    }

    public UserAccount getUserByEmail(String email) {
        return userRepo.findByEmail(email).orElse(null);
    }

    public String getIdUserByName(String username) {
        return userRepo.findByUsername(username).map(UserAccount::getId).orElse(null);
    }

    public void updateInforUser(String id, String fullname, String phone, String address, String newpass, String avt) {
        UserAccount user = userRepo.findById(id).orElse(null);
        if (user != null) {
            user.setName(fullname);
            user.setPhone(phone);
            user.setAddress(address);
            user.setPassMaHoa(newpass);
            user.setAvt(avt);
            userRepo.save(user);
        }
    }

    public void UpdateUserInfo(String id, String name, String email, Object o, Object o1, Object o2) {
        // Tùy vào o, o1, o2 là gì mới xử lý được
    }

    public boolean isUserInOrder(String userId){
        // Cần kết nối với OrderRepository, giả định:
        return false;
    }

    public boolean addRoleadmin(String idAdmin, String table, int permission){
        AdminRole role = new AdminRole();
        role.setUserId(idAdmin);
        role.setTableName(table);
        role.setPermission(permission);
        roleRepo.save(role);
        return true;
    }

    public void removePermission(String idAdmin, String table, int permission){
        roleRepo.deleteByUserIdAndTableNameAndPermission(idAdmin, table, permission);
    }

    public AdminRole getAdminRole(String idAdmin, String table, int per){
        return roleRepo.findByUserIdAndTableNameAndPermission(idAdmin, table, per);
    }

    public UserAccount getUserLoginFace(String user) {
        return userRepo.findByUsername(user).orElse(null);
    }
}