package com.zw.rule.jeval.function.math;

import com.zw.rule.jeval.Evaluator;
import com.zw.rule.jeval.function.Function;
import com.zw.rule.jeval.function.FunctionException;
import com.zw.rule.jeval.function.FunctionResult;

/**
 * Created by Administrator on 2017/5/5.
 */
public class Exp implements Function {
    public Exp() {
    }

    public String getName() {
        return "exp";
    }

    public FunctionResult execute(Evaluator evaluator, String arguments) throws FunctionException {
        Double result = null;
        Double number = null;

        try {
            number = new Double(arguments);
        } catch (Exception var6) {
            throw new FunctionException("Invalid argument.", var6);
        }

        result = new Double(Math.exp(number.doubleValue()));
        return new FunctionResult(result.toString(), 0);
    }
}
