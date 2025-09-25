package co.yixiang.yshop.module.system.controller.admin.auth;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 简单注册响应 VO
 *
 * @author yshop
 */
@Schema(description = "管理后台 - 简单注册 Response VO")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SimpleRegisterRespVO {

    @Schema(description = "用户编号", requiredMode = Schema.RequiredMode.REQUIRED, example = "1024")
    private Long userId;

    @Schema(description = "用户名", requiredMode = Schema.RequiredMode.REQUIRED, example = "yshop")
    private String username;

    @Schema(description = "用户昵称", requiredMode = Schema.RequiredMode.REQUIRED, example = "芋道")
    private String nickname;

    @Schema(description = "响应消息", requiredMode = Schema.RequiredMode.REQUIRED, example = "注册成功")
    private String message;

}