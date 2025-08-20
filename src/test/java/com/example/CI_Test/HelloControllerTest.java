package com.example.CI_Test;

import com.example.CI_Test.controller.TestController;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.assertThat;

public class HelloControllerTest {

    @Test
    void testHello() {
        TestController controller = new TestController();
        String result = controller.sayHello();
        assertThat(result).isEqualTo("Hello from CI/CD test project!");
    }
}